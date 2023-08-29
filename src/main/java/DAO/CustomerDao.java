package DAO;

import Entity.Customer;

/**
 * @author NHUTLQ
 */
public class CustomerDao extends AbstactDao<Customer> {

    public Customer findByFullname(String fullname) {
        String jpql = "SELECT o FROM Customer o WHERE o.fullname = ?0";
        return super.findOne(Customer.class, jpql, fullname);
    }

    public Customer addCustomer(Customer entity) {
        return super.create(entity);
    }

    public Customer updateCustomer(String fullname, String phone) {
        Customer customer = findByFullname(fullname);
        if (customer != null) {
            customer.setFullname(fullname);
            customer.setPhonenumber(phone);
            return super.update(customer);
        }
        return customer;
    }
}
